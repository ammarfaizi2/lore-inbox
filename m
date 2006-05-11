Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWEKND0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWEKND0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 09:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWEKNDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 09:03:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:37271 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751676AbWEKNDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 09:03:25 -0400
Message-ID: <4463369B.6020207@suse.de>
Date: Thu, 11 May 2006 15:05:31 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060411)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ELF entry point (i386)
References: <43FC4682.6050803@suse.de>	<m1bqwkc0l1.fsf@ebiederm.dsl.xmission.com> <440C363F.8000503@suse.de>	<m1r75f8k21.fsf@ebiederm.dsl.xmission.com> <440D8D97.6000300@suse.de> <m1y7zm16nn.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1y7zm16nn.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> I have some pending patches that make a bzImage a ET_DYN executable.
> Would that be interesting to you?  Especially if that would just mean
> your initial page tables got to set physical == virtual?

ping, do you have a url to the patches for me?

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
Erst mal heiraten, ein, zwei Kinder, und wenn alles läuft
geh' ich nach drei Jahren mit der Familie an die Börse.
http://www.suse.de/~kraxel/julika-dora.jpeg
