Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUDUVIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUDUVIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 17:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbUDUVI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 17:08:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59838 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263720AbUDUVH3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 17:07:29 -0400
Date: Wed, 21 Apr 2004 18:08:44 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Sam Hopkins <sah@coraid.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: AoE inclusion into 2.4.x
Message-ID: <20040421210844.GE16891@logos.cnet>
References: <58a06a347fde8a8a90c9fbff504a943f@borf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a06a347fde8a8a90c9fbff504a943f@borf.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 02:27:51PM -0400, Sam Hopkins wrote:
> When I started development 2.6 was barely out.  I wanted to develop
> for a stable system to start.  I've looked at what has changed betwixt
> v4 and v6 and am in the process of porting.

as Jeff noted, getting it into v2.6 first is also good idea. After a few weeks it 
then can be included into v2.4 (still in time for v2.4.27). 

Please avoid having v2.4 compatibility stuff in the v2.6 driver. It will be easier 
for it to be accepted this way.
