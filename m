Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbTJJG2l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 02:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTJJG2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 02:28:41 -0400
Received: from holomorphy.com ([66.224.33.161]:29312 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262508AbTJJG2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 02:28:40 -0400
Date: Thu, 9 Oct 2003 23:30:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
       Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031010063039.GA700@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stuart Longland <stuartl@longlandclan.hopto.org>,
	Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
	Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F864F82.4050509@longlandclan.hopto.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 04:19:46PM +1000, Stuart Longland wrote:
Stephan von Krawczynski wrote:
>>* hotplug CPU
>>* hotplug RAM

Generally thought of as desirable, but hotplug RAM needs a *LOT* of
qualification.


On Fri, Oct 10, 2003 at 04:19:46PM +1000, Stuart Longland wrote:
> * hotplug motherboard & entire computer too I spose ;-)

Um, this is worse than the above wrt. being too vague.


On Fri, Oct 10, 2003 at 04:19:46PM +1000, Stuart Longland wrote:
> Although sarcasm aside, a couple of ideas that have been bantered around 
> on this list (and a few of my own ideas):
> 	- /proc interface alternative to modutils/module-init-tools.
> 		That is, to have a directory of virtual nodes in /proc
> 		to provide the functionality of insmod, rmmod, lsmod &
> 		modprobe would be great -- especially from the viewpoint
> 		of recue disk images, etc.

No way in Hell.


-- wli
