Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283680AbRLEBaa>; Tue, 4 Dec 2001 20:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283677AbRLEBaP>; Tue, 4 Dec 2001 20:30:15 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:41485 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S283660AbRLEB3y> convert rfc822-to-8bit; Tue, 4 Dec 2001 20:29:54 -0500
Date: Wed, 5 Dec 2001 02:29:52 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011205022952.F28582@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16BKeT-0001zt-00@DervishD.viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <E16BKeT-0001zt-00@DervishD.viadomus.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2001, RaúlNúñez de Arenas Coronado wrote:

>     Well, IMHO Python is good only in being big and doing things
> slow, but... why the parser cannot be built over flex/bison?. That
> way it can be 'pregenerated' and people won't need additional tools
> to build the kernel.

Go ahead. Until then, as an interim solution, ship the .depend stuff as
well so people won't need make dep...

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
