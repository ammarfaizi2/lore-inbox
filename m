Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUGAJ1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUGAJ1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 05:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUGAJ1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 05:27:03 -0400
Received: from herkules.viasys.com ([194.100.28.129]:63115 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S264373AbUGAJ1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 05:27:00 -0400
Date: Thu, 1 Jul 2004 12:26:57 +0300
From: Ville Herva <vherva@viasys.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6-mm4 IDE] HPT370A/i815 ATAPI problems
Message-ID: <20040701092657.GD16073@viasys.com>
Reply-To: vherva@viasys.com
References: <20040522185604.GA11309613@niksula.cs.hut.fi> <20040523200716.GZ23361@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523200716.GZ23361@viasys.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.25-rc2+mremap-unmap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 11:07:16PM +0300, you [Ville Herva] wrote:
> On Sat, May 22, 2004 at 09:56:06PM +0300, you [Ville Herva] wrote:
> >
> > And I just noticed DMA is not enabled for DW-7802TE when attached to HPT.
> 
> So my original question stays: is there any change a firmware upgrade could
> help? (I'm kind of wary of trying random firmwares, since Mitsumi doesn't
> seem to provide one, and the most linked firmware site
> (http://www.herrie.org/) says it was just defaced in the front page...
> Besides all those firmwares are either "hacked" or "modified".)
> 
> What else might be the problem?

It seems the unit was faulty. I got a warranty replacement (different
brand/model, though), and it doesn't seem to cause lockups on i815. I
haven't tried it on HTP370, though.


-- v -- 

v@iki.fi

