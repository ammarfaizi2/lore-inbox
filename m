Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131366AbQL2PNS>; Fri, 29 Dec 2000 10:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131360AbQL2PNI>; Fri, 29 Dec 2000 10:13:08 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:52914 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131029AbQL2PNB>; Fri, 29 Dec 2000 10:13:01 -0500
Date: Fri, 29 Dec 2000 16:41:49 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Giacomo A. Catenazzi" <cate@student.ethz.ch>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@torque.net
Subject: Re: [PATCH] Processor autodetection (when configuring kernel)
Message-ID: <20001229164149.E17545@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3A4C941E.EA824F87@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A4C941E.EA824F87@student.ethz.ch>; from cate@student.ethz.ch on Fri, Dec 29, 2000 at 02:39:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 02:39:42PM +0100, Giacomo A. Catenazzi wrote:
> +    {TransmetaCPU,GenuineTMx86}:* ) echo CONFIG_MCROSUE ;;   
+    {TransmetaCPU,GenuineTMx86}:* ) echo CONFIG_MCRUSOE ;;   

This is just a typo, right? ;-)

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
