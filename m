Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130490AbQLCNA6>; Sun, 3 Dec 2000 08:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130511AbQLCNAr>; Sun, 3 Dec 2000 08:00:47 -0500
Received: from dusdi5-212-144-140-079.arcor-ip.net ([212.144.140.79]:39941
	"EHLO al.romantica.wg") by vger.kernel.org with ESMTP
	id <S130490AbQLCNAf>; Sun, 3 Dec 2000 08:00:35 -0500
Date: Sun, 3 Dec 2000 13:30:04 +0100
From: Jens Taprogge <taprogge@idg.rwth-aachen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems building test10 or test11 with AMD Duron CPU
Message-ID: <20001203133004.A12269@al.romantica.wg>
Mail-Followup-To: Jens Taprogge <taprogge@idg.rwth-aachen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012031150440.15304-100000@maui.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012031150440.15304-100000@maui.kotnet.org>; from frederik@maui.kotnet.org on Sun, Dec 03, 2000 at 11:56:32AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2000 at 11:56:32AM +0100, Frederik Vanrenterghem wrote:
> Hi,
> 
> I've been unable to build kernel 2.4.0test10 or test 11 on my new system,
> which has an Asus A7V mb and a AMD Duron 700 CPU, running Debian Woody
> (gcc 2.95.2). If I select as CPU: Athlon/K7, building the kernel fails. If
> I choose PPro, the kernel builds fine, and I can use it.
> Is this normal behaviour? I would expect to be able to build a kernel on
> this system with Athlon/K7 optimisations, since a Duron is from the same
> line of CPU's, or is that incorrect?

I have got the exact same setup. Everything works fine when compiling
for Athlon/K7.

I will send you my .config.

Jens

-- 
Jens Taprogge


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
