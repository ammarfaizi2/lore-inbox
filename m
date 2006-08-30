Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWH3Rw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWH3Rw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWH3Rw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:52:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60048 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751262AbWH3Rw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:52:57 -0400
From: Andi Kleen <ak@suse.de>
To: pageexec@freemail.hu
Subject: Re: [PATCH][RFC] exception processing in early boot
Date: Wed, 30 Aug 2006 19:52:54 +0200
User-Agent: KMail/1.9.3
Cc: Willy Tarreau <w@1wt.eu>, Riley@williams.name, davej@redhat.com,
       linux-kernel@vger.kernel.org
References: <20060830063932.GB289@1wt.eu> <200608301830.40994.ak@suse.de> <44F5E818.20898.5C230A79@pageexec.freemail.hu>
In-Reply-To: <44F5E818.20898.5C230A79@pageexec.freemail.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200608301952.54180.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 19:33, pageexec@freemail.hu wrote:

> 
> > But I went with the simpler patch with some changes now 
> > (added PANIC to the message etc.) 
> 
> can you post it please?

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/i386-early-exception

-Andi

P.S.: If you provide patches in the future again also please provide
a real name and a Signed-off-by line
