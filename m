Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVD0NmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVD0NmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVD0NmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:42:03 -0400
Received: from gate.in-addr.de ([212.8.193.158]:52926 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261507AbVD0Nl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:41:57 -0400
Date: Wed, 27 Apr 2005 15:25:47 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: David Teigland <teigland@redhat.com>, Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] dlm: build
Message-ID: <20050427132547.GY4431@marowsky-bree.de>
References: <20050425151333.GH6826@redhat.com> <20050425142525.70e72e93.akpm@osdl.org> <200504260352.j3Q3qGEP010127@turing-police.cc.vt.edu> <20050426055235.GD12096@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050426055235.GD12096@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-26T13:52:35, David Teigland <teigland@redhat.com> wrote:

> Other transports are definately a possibility and something that should be
> quite simple since it's all encapsulated in lowcomms as you've mentioned.

That begs the question why you have choosen SCTP for the newer DLM
versions. Curiousity kills the cat, so I'm asking ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

