Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265859AbRGDQFb>; Wed, 4 Jul 2001 12:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265868AbRGDQFW>; Wed, 4 Jul 2001 12:05:22 -0400
Received: from imladris.infradead.org ([194.205.184.45]:63244 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S265859AbRGDQFJ>;
	Wed, 4 Jul 2001 12:05:09 -0400
Date: Wed, 4 Jul 2001 17:05:04 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Alan Cox <laughing@shared-source.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.20pre7
In-Reply-To: <20010704164043.A4046@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0107041701080.6660-101000@infradead.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-842912328-109199206-994262704=:6660"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---842912328-109199206-994262704=:6660
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Alan.

 > Linux 2.2 is now firmly into maintainance state. Patches for
 > neat new ideas belong in 2.4. Generally new drivers belong in
 > 2.4 (possibly in 2.2 as well after 2.4 shows them stable).
 > Expect me to be very picky on changes to the core code now.

Can I submit the attached patch for both 2.2 and 2.4 kernels? It adds
a new script that lists all the configuration variables used, together
with details of how many times each variable is used.

Best wishes from Riley.

---842912328-109199206-994262704=:6660
Content-Type: APPLICATION/x-gzip; name="linux-vars.diff.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107041705040.6660@infradead.org>
Content-Description: scripts/varlist
Content-Disposition: attachment; filename="linux-vars.diff.gz"

H4sICFw+QzsCA2xpbnV4LXZhcnMuZGlmZgCdVttu4zYQfZa+YlZxoGYVWbKx
aXOBgQDbLbpF4RitgxbIpaYpyiIqi65I5dLN9mfyo50hLcu7MVogUWBbwzln
boeUMpnnEDf1GDSv5crof5I7VpdSm9bQ3vtxHL9w8qZFAz+xCmAA6eA0TfEf
BiffpX4URV8zOOemguEABken6dHpuxMYpunAPz+HOD1MIRocHg/g/NyP9t4k
c1klc6YLP/IjmcMV9PYgrgRGujkDU4jKjwD/BC8UXGq2EKcwQ39RsaWAXjoD
uslkvXZ7kAaGR0d+lEti3INpIfU6RdDNcslqqYUmZuCqyuWiqZmRqgJMX7J5
adeYAVYLYNw0rCwfiafBKCCrHUBTCwG5qu0S01pxyQw660dtxPIQtEG/akHL
RGQeVwJUToQuEua3ZJm1CcaLTSKHwKrMkmYiZ01pcKVsbCjLgwuta9/V+tGQ
q6zW9W1Hwq8WoBq9VSzTMBcuPcxF5S01V9grjH+v6sytNdQ3bC+Vil2xdYml
qIwGhQiqHyUyw0FJLmZ9Ivph3ZXW2GEOiWmT7L0CLVYMG+qy1uu0T21dnkN7
dpRt5qA4b2qbP0XIZa1Nt4iDYoT0XkZ2vfJYqdV/MmqBY84AK9DNXIu/GsRa
yi+C7CitD5dVKf8Utkm2oZ5HhOsmbZWHE96KThPCdMjBYvD3+GKKkl4JTnoy
ymVIcd+vFSj6hShXWD2OshMBirBZboSMWdj1/5MwKZ52VUYsQtpsA+fXl1VA
nQjed7dOnBigUmv+SqGYqztV3tk4nZJehOKsrh+xr7ywjaKoLv28qbh1y4Xh
xTcH8Glr+we9YQBPwBsDcQYhXnEOvYEfff4CuhCmJFl1aI5ZzlBqGVIMAoil
PTw2pc3Au/Yj7wlzg/C6QuLn0PPWNupZqJPr6+ckWYTeludzaL29LVus0WQo
s3AbH+gkvLoNb96GyVQ8mORMJ7eQJMHaZVGLFcR3EN7udWydsbfLiEdl+NIq
Si16O+y53GWlLY563bFyxeK/b97iYrNjUaum5mJXeLef/5grVYZfT2VVKy70
1lBKxVkJY7iYwGQAkyH88uHXKX1c/jwFvD78PoXfPn4//XH0LiUmwtwXKDSo
BcsIZl22sGeQKczIUYxmuUvsHoc+wamzmheJPP42wSzd6DstjUhJw3iGaPsM
QsQQekQawJsRBHhtnkYeJdLGWOtygsIMnD9x0LPHW9WyMjil/fhEh7h6MQnQ
yvFpBUGf7uwWsWx96thBiwj2494nW/lnDfv6GvcaFuD4MSixeN7ZWYstxMNr
oYh5LVQbhC1ei3Zn5oHXtc86dA11rd/sKXBbDQ33HOJyZr3Ho6H9dqLAF4cx
LuE7wZRmZZXg2WjdII5dbiHQ4Y8nAp0xBNsanYOMR72r3jga3lhLpirRFSA0
406Nzm5l3p457oB5atWOv7SqUWLzHN96/H8BA2dcaIcJAAA=
---842912328-109199206-994262704=:6660--
