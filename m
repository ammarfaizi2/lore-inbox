Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270613AbUJUEbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270613AbUJUEbF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 00:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270520AbUJUEZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 00:25:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40364 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270513AbUJUEUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 00:20:45 -0400
Date: Thu, 21 Oct 2004 00:20:36 -0400
From: Dave Jones <davej@redhat.com>
To: Jim Nelson <james4765@verizon.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Structural changes for Documentation directory
Message-ID: <20041021042036.GB14189@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jim Nelson <james4765@verizon.net>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <4176CFE3.2030306@verizon.net> <20041020153058.6de41ed8.akpm@osdl.org> <4176EBD8.3050306@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4176EBD8.3050306@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 06:51:04PM -0400, Jim Nelson wrote:

 > True.  "./2.6-docs" would reflect the the intent of having 
 > version-specific information, with the "./Documentation" directory left 
 > for general information and files of historical interest.

version numbers in directories are nearly always a bad idea,
as they always tend to look a bit silly when the subsequent
release is made.

		Dave

