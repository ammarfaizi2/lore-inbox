Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWACQjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWACQjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWACQjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:39:10 -0500
Received: from cantor2.suse.de ([195.135.220.15]:9448 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751441AbWACQjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:39:09 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/26] gitignore: x86_64 files
References: <20060103132035.GA17485@mars.ravnborg.org>
	<11362947263966@foobar.com>
From: Andi Kleen <ak@suse.de>
Date: 03 Jan 2006 17:39:06 +0100
In-Reply-To: <11362947263966@foobar.com>
Message-ID: <p73wthhi7v9.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> From: Brian Gerst <bgerst@didntduck.org>
> Date: 1135744791 -0500
> 
> Add filters for x86_64 generated files.

Please don't submit this patch. If anything such ignore lists
for specific SVMs should be in a central place, but not spread
everywhere.

-Andi
