Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVFDAHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVFDAHx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 20:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVFDAGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 20:06:43 -0400
Received: from animx.eu.org ([216.98.75.249]:58037 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261186AbVFDAFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 20:05:45 -0400
Date: Fri, 3 Jun 2005 20:01:56 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
Message-ID: <20050604000156.GA18065@animx.eu.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <42A0D88E.7070406@pobox.com> <20050603163843.1cf5045d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603163843.1cf5045d.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Subject: Double free of initramfs

Is there a patch to fix this?  I've noticed a solid lockup when trying to
umount initramfs after a pivot_root.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
