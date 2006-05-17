Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWEQNAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWEQNAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWEQNAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:00:12 -0400
Received: from main.gmane.org ([80.91.229.2]:44762 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932237AbWEQNAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:00:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ganesan Rajagopal <rganesan@debian.org>
Subject: Van Jacobson Channels - Earlier Work
Date: Wed, 17 May 2006 18:14:50 +0530
Message-ID: <xkvhves495x9.fsf@grajagop-lnx.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: grajagop-lnx.cisco.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.51 (gnu/linux)
Cancel-Lock: sha1:MiBoAHN2onjKROOEmPfoKSKlU14=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

A colleague at work pointed me to a 10 year old paper OSDI paper called Lazy
Receiver Processing (See http://www.cs.rice.edu/CS/Systems/LRP/). The work
appears similar to what Van Jacobson is proposing in his paper. The
emphasis is more on fair resource allocation but the core ideas seems
similar. The implementation is not on Linux (it's on 4.4 BSD) but the paper
is worth checking out.

Ganesan

-- 
Ganesan Rajagopal

