Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSHGARz>; Tue, 6 Aug 2002 20:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSHGARz>; Tue, 6 Aug 2002 20:17:55 -0400
Received: from jalon.able.es ([212.97.163.2]:59355 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316576AbSHGARy>;
	Tue, 6 Aug 2002 20:17:54 -0400
Date: Wed, 7 Aug 2002 02:21:26 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre1
Message-ID: <20020807002126.GG2733@werewolf.able.es>
References: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Aug 06, 2002 at 00:40:56 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


On 2002.08.06 Marcelo Tosatti wrote:
>
>So here goes -pre1, with a big -ac and x86-64 merges, plus other smaller
>stuff.
>
>
><jgarzik@mandrakesoft.com> (02/08/03 1.596.3.6)
>	Add Intel e100 net driver.
>
><jgarzik@mandrakesoft.com> (02/08/03 1.596.3.7)
>	Add e1000 gige net driver.
>

Configure.help missing for those. Attached.

btw, I don't like this also, but is the official one...

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-jam0, Mandrake Linux 9.0 (Cooker) for i586
gcc (GCC) 3.2 (Mandrake Linux 9.0 3.2-0.2mdk)

--17pEHd4RhPHOinZp
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="intel-eth-help.diff.gz"
Content-Transfer-Encoding: base64

H4sICCJnUD0AA2ludGVsLWV0aC1oZWxwLmRpZmYA1VnZbts4FH0ef8V9GiTwJlJ70AmqaRYE
aNKgDYq+BbRF20RkUdASJ38/l1psRfGShIMZlMiDZPEenruIvEcJxWwGwyK9SYCOrBHx06k9
PpPTYsnjnOVCxuMvMp6JeZHy0YJHrWmMkb0ze8Ph8I2gf9wtCgiKOQAB4pxQ/4R6QA2D9vr9
/ttXbMNQ48Qw8a+C+fwZhoSYpjlwoI8XLhkQagL+/OXbzcXV5f35+e33b8QwegDAYCnDIuID
yNgzXMOCpxxYHELKWQifZiLiJy9pVPOzUf6UnwLLFMiKRxFebp0e83wl0wcRz9XlsG096kGv
f57jkudPScqzDG5TOUZikBVJItMcjjjeDSCIcp7GLOdwFec8gjAVjzw97vUbh5QzfYC7hcjq
hw1EVpkcfT8GdLoEn7GliJ5BzoCFLEHkbACrhZguQGGIeBoVIc9Oen11iwPjnqcyihAUgsoC
btiSw/bxt2RpCFdnWW0+XI/2tbrbOtbP1+t71La9+mntQx9uv1ytybwcjuMZHhk+PT0NoEZ4
53A833FKhH0MrlnM5lwlukvE8bH6LB0GrkFc0ysRPghAiemZh1w4K1gEt6rQfvBUFc3aEZdY
pmFquUAIdXwdhIB61HUO+aAKocu+YWDYttGxN17aw48dxsreplaVhJa9/w7+tuOZWoUYoAeO
qVEGAaHE1aRATaqPYGgiELedyHcO1/IwFZr29sFCOuPZQy6T15Xk2sR13I8Xklrfp7oRrBjo
ZJF42gi6HEiVh4/uiiqR5Z4EWzKx3lJ27gi4rfquvSuTm0rYeTSUBBytbVUhWIdrcdfOvtmU
WvakY3+9u5YDPFx9d8e7tFk/CB9ZPOXhtlB81HHXs7ReAtey682waWxuvr+i/vN8p++4G5ue
VvIQwaW23ploeobmduy7xDmQwJ+7KyDAzoBqdQaKwf8eBYpD71Ciputv4lh1q3cS8GUTs2fI
FyyHZ1mkTZMN2JrXPTkPBzATqDGw9YdJ3S5DXCwn9dsh4/JRbTmCr1I+wEwiFkRsggKgRF+g
4mAwYelUhpVmYW0QUYGg2RIn4+Zr2c7QMAgcZeIJQjEXKA4Wz8mCq4kp5/VvxyN8afNaDeRK
UeSyRIpElivVUK2Ba0/kIx9Vjl8guaVE6STiakGUPsqNhVwpcxHiBqDC0o7IAOaywVYYTaX9
CWeVhMGgXBZC+Zav1cgiz5OT8biO5EgocTOaymXzS6O3xvUi4ySVWNFj7Id9d7TIlxu+pU8o
qtCrSlY11V9DNEpKBf6riAsslYzzLhOWJFna5jFNRZJnw3DWULqvHrIsqUyvVZyyhE/FTEy7
AZvWIhf1Ykmw5oBZwHwq6wMaUwnGWlz2u5IQr1iUSWCPTGAdRRzKCqokKRzBX1BWUqUFpyyG
Ca8KKeOqaBWDShkvMfEhzFK5LDmmRRwrvg8oUjGMK6wortbDZMOKxfnxqGLCm6VWAvXyhOMa
qCpDKDnLEcDVbG2jCgPDmaCzIPKSqALRFOulUlc4HxHrGM+uljbgUszZBAmWMh5tmnf8hTZ/
uzg3YF4D8gZwLddL3h3Frq3WtfX6C8Ve3mNHYdH62as4beutXMOgDtXo65TWcw2z05hZZpfE
xb7WDs92y9AiEZgejkMk7vaQwKPRs3Q6XEXC9K0uCatL4tceFoFNbM84iLAnmIFtWJ51COFu
d5cJgUN9q5tPo4twvQciwHbR6MbB3oKw2wu/kRstBGcbh53NNiIQcpDDvkj6xKH03QhHX38d
txG6uXjtxcU+LxDBqFXTv3DYv/Ws/6R91p9u+M7xTErRwTZldXLUUO1epGoG1vu4+rw7yUT+
Jmqn/9ER/1ue8b/HIQ/ncRm3W7lC/zb6tdf998H97bX6+I8znuuaefktv+4m1QfKpqOc4lGL
TqYqLIlapfcPWYrB/ZQZAAA=

--17pEHd4RhPHOinZp--
