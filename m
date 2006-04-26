Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWDZSIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWDZSIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWDZSIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:08:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:14227 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932307AbWDZSIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:08:45 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Peterson <dsp@llnl.gov>
Subject: Re: [PATCH 1/2] mm: serialize OOM kill operations
Date: Wed, 26 Apr 2006 20:05:47 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, akpm@osdl.org
References: <200604251701.31899.dsp@llnl.gov> <p73k69d7xl8.fsf@bragg.suse.de> <200604261015.28922.dsp@llnl.gov>
In-Reply-To: <200604261015.28922.dsp@llnl.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604262005.47387.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Any suggestions for a location?

->flags

-Andi

