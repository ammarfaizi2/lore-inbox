Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281142AbRKYWAk>; Sun, 25 Nov 2001 17:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281140AbRKYWAb>; Sun, 25 Nov 2001 17:00:31 -0500
Received: from argus.posten.se ([147.14.10.164]:41409 "HELO argus.posten.se")
	by vger.kernel.org with SMTP id <S281129AbRKYWAV>;
	Sun, 25 Nov 2001 17:00:21 -0500
Message-ID: <3C016AC8.3020105@posten.se>
Date: Sun, 25 Nov 2001 23:03:52 +0100
From: Pawel Worach <_nospam_pawel.worach@posten.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011125
X-Accept-Language: en-us
MIME-Version: 1.0
To: Niels Christiansen <nchr@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: /var corruption after 2.4.15 and 2.5.0 reboot
In-Reply-To: <fa.l99gmcv.1agq8qd@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Niels Christiansen wrote:

 > [1.] One line summary of the problem:
 >      /var corruption after 2.4.15 and 2.5.0 reboot


Both the 2.4.15 and 2.5.0 kernels have a filesystem corruption bug,
don't use them. Please apply the 2.4.16-pre1 (or 2.5.1-pre1) patch,
you can find it on http://www.kernel.org/.

Regards
Pawel Worach


