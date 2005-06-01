Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVFAJyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFAJyi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVFAJyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:54:38 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:53490 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261151AbVFAJyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:54:37 -0400
Message-ID: <429D85D3.1060309@stud.feec.vutbr.cz>
Date: Wed, 01 Jun 2005 11:54:27 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm2
References: <20050601022824.33c8206e.akpm@osdl.org>
In-Reply-To: <20050601022824.33c8206e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> +add-offseth-to-dontdiff.patch
> 
>  Don't generate diffs for offset.h.  (Why is anyone using the dontdiff file
>  anyway?)

Well, it's recommended it Documentation/SubmittingPatches. I don't know 
how else can I generate a diff for more than one file.

Michal
