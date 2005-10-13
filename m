Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbVJMBRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVJMBRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbVJMBRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:17:46 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:46469 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964850AbVJMBRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:17:45 -0400
Date: Wed, 12 Oct 2005 18:17:35 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/21] mm: update_hiwaters just in time
In-Reply-To: <Pine.LNX.4.61.0510130148350.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.62.0510121807090.11311@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0510130148350.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me. Great innovative idea on how to reduce the resources 
needed for the counters.

Jay, what do you say?
