Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbSA0MZ0>; Sun, 27 Jan 2002 07:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285593AbSA0MZO>; Sun, 27 Jan 2002 07:25:14 -0500
Received: from pc3-redb4-0-cust131.bre.cable.ntl.com ([213.106.223.131]:7673
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S284732AbSA0MZE>; Sun, 27 Jan 2002 07:25:04 -0500
Date: Sun, 27 Jan 2002 12:25:01 +0000
From: Mark Zealey <mark@zealos.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: fonts corruption with 3dfx drm module
Message-ID: <20020127122501.GA23825@itsolve.co.uk>
In-Reply-To: <20020127113553Z287979-13997+10785@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020127113553Z287979-13997+10785@vger.kernel.org>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.17-wli2 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2002 at 12:15:01PM +0000, Diego Calleja wrote:

> I can see fonts corruption when switching from X to console. I use last
> stable kernel, but it's been hapenning from earlier versions. I use
> iso-8959-15 fonts in console, with tdfx drm module for X, my video card is voodoo 3 3000 PCI.
> I hope this can help.

Yes, I've been seeing this too, it's happened in 2.2.19, 2.2.20 and 2.4.17 (for
me). Voodoo banshee PCI card.. it can be annoying, but another switch usially
fixes it...

-- 

Mark Zealey
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
