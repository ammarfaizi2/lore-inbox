Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269003AbUJUFSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269003AbUJUFSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270622AbUJUFP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:15:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53437 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270633AbUJUFFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:05:33 -0400
Date: Thu, 21 Oct 2004 01:05:28 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jim Nelson <james4765@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Structural changes for Documentation directory
Message-ID: <20041021050528.GA26814@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Jim Nelson <james4765@verizon.net>,
	linux-kernel@vger.kernel.org
References: <4176CFE3.2030306@verizon.net> <20041020153058.6de41ed8.akpm@osdl.org> <4176EBD8.3050306@verizon.net> <20041021042036.GB14189@redhat.com> <41773D3F.2040801@verizon.net> <20041020220037.2e209907.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020220037.2e209907.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 10:00:37PM -0700, Andrew Morton wrote:
 > >  The other possibility is to have a TODO file with a list of out-of-date 
 > >  files, and have the removal of the file listing in the TODO file be part 
 > >  of the patch submission.
 > 
 > It all sounds too complex.  ./docs/ is fine.

asides from bloating up interdiffs, what does moving stuff around
gain us over just fixing stuff in place ?  Do we really have
that much out of date documentation to justify this ?

		Dave

