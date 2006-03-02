Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWCBNdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWCBNdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 08:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWCBNdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 08:33:09 -0500
Received: from duempel.org ([81.209.165.42]:19659 "HELO duempel.org")
	by vger.kernel.org with SMTP id S1750868AbWCBNdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 08:33:08 -0500
Date: Thu, 2 Mar 2006 14:32:00 +0100
From: Max Kellermann <max@duempel.org>
To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: 2.6.15.4: NFS-related BUG in radix_tree_tag_set()
Message-ID: <20060302133200.GA24460@roonstrasse.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
References: <20060302130512.GA23671@roonstrasse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302130512.GA23671@roonstrasse.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006/03/02 14:05, Max Kellermann <max@duempel.org> wrote:
> The BUG_ON() failed in lib/radix-tree.c:372 :

I just found the patches by Tony Griffiths and Neil Brown - I'm going
to try them now.

Max

