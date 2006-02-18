Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWBRMHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWBRMHG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWBRMHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:07:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52097 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751149AbWBRMG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:06:59 -0500
Date: Sat, 18 Feb 2006 12:06:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>, Greg KH <greg@kroah.com>,
       Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060218120617.GA911@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Daniel Barkalow <barkalow@iabervon.org>, Greg KH <greg@kroah.com>,
	Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <Pine.LNX.4.64.0602122256130.6773@iabervon.org> <20060213062158.GA2335@kroah.com> <Pine.LNX.4.64.0602130244500.6773@iabervon.org> <20060213175142.GB20952@kroah.com> <d120d5000602131003l7bd1451bs64076475fdd6079c@mail.gmail.com> <Pine.LNX.4.64.0602131339140.6773@iabervon.org> <43F641A2.50200@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F641A2.50200@tmr.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:35:30PM -0500, Bill Davidsen wrote:
> It would be nice to have one place to go to find burners, and to have 
> the model information in that place.

/proc/sys/dev/cdrom/info

