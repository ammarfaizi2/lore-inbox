Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282706AbRLDR3r>; Tue, 4 Dec 2001 12:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281555AbRLDR2i>; Tue, 4 Dec 2001 12:28:38 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:51214 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S281703AbRLDRUf>; Tue, 4 Dec 2001 12:20:35 -0500
Date: Tue, 4 Dec 2001 18:20:33 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204182033.B12538@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011204173309.A10746@emma1.emma.line.org> <E16BJ9v-0002ii-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E16BJ9v-0002ii-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2001, Alan Cox wrote:

> > Creating a dependency on Python? Is a non-issue. Current systems that
> > are to run 2.5 or 2.6 are bloated beyond belief by glibc already, Python
> > is nice and it does not create such unmaintainable mess. Whether
> 
> Python2 - which means most users dont have it.

Every new kernel version required new tools, 2.2 particularly many, 2.4
also some, so it's just one more tool to add in the end.

Current distributions already ship with Python2, and probably all will
when distributors know that Python2 will be needed to configure Linux
2.5 or 2.6.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
