Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTJANkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTJANkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:40:46 -0400
Received: from intra.cyclades.com ([64.186.161.6]:45769 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262174AbTJANko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:40:44 -0400
Date: Wed, 1 Oct 2003 10:21:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: syn uw <syn_uw@hotmail.com>
Cc: xose@wanadoo.es, <linux-kernel@vger.kernel.org>,
       <marcelo.tosatti@cyclades.com.br>, <atulm@lsil.com>,
       <linux-megaraid-devel@dell.com>
Subject: RE: Megaraid does not work with 2.4.22
In-Reply-To: <BAY99-F60MLDthODt9C000008de@hotmail.com>
Message-ID: <Pine.LNX.4.44.0310011017440.3343-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Oct 2003, syn uw wrote:

> >I don't know what is the opinion of other people :-?
> >Maybe linux-scsi members hold other opinion.
> 
> Well I for example would be more than pleased to see megaraid 2.x included 
> in the next stable 2.4.x Linux kernel !! I had a look at the current 
> changelogs of 2.4.23 and still no traces about a megaraid v2 inclusion :(( 
> Hopefully that will happen soon !

Having two drivers for the same controller is not a good thing from a user
point of view. I just asked Atul privately but will do so again here: Why 
do we need "megaraid2" ? 


