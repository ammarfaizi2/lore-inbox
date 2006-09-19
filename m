Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWISSiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWISSiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbWISSiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:38:16 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37064 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750785AbWISSiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:38:15 -0400
Date: Tue, 19 Sep 2006 11:38:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Sandeep Kumar <sandeepksinha@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Efficient Use of the Page Cache with 64 KB Pages
In-Reply-To: <37d33d830609150150v30dc32en57f8c5e43c30aef3@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609191136580.6460@schroedinger.engr.sgi.com>
References: <37d33d830609150150v30dc32en57f8c5e43c30aef3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006, Sandeep Kumar wrote:

> So, how far is this feature feasible for the linux main line kernel ?
> Is, this feature already supported ?

IA64 has supported 64k page size from the beginning. Since some 
years before the end of the last decade. It is only the hardware 
limitations on IA32 that hold us back.


