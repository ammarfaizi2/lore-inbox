Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWJEVqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWJEVqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWJEVp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:45:59 -0400
Received: from mx1.suse.de ([195.135.220.2]:4258 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932292AbWJEVp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:45:27 -0400
From: Andi Kleen <ak@suse.de>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: Re: [PATCH 02/14] uml: revert wrong patch
Date: Thu, 5 Oct 2006 23:45:09 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20061005213212.17268.7409.stgit@memento.home.lan> <20061005213839.17268.28062.stgit@memento.home.lan>
In-Reply-To: <20061005213839.17268.28062.stgit@memento.home.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052345.09704.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 23:38, Paolo 'Blaisorblade' Giarrusso wrote:

> Andi Kleen pointed out that -mcmodel=kernel does not make sense for userspace
> code and would stop everything from working, 

did it work at all with it? 

-Andi
