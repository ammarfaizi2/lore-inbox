Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVAXXXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVAXXXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVAXXWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:22:45 -0500
Received: from wh0rd.org ([80.68.88.204]:48394 "EHLO wh0rd.org")
	by vger.kernel.org with ESMTP id S261665AbVAXXIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:08:05 -0500
From: Mike Frysinger <vapier@gentoo.org>
Organization: wh0rd.org
To: Edward Peschko <esp5@pge.com>
Subject: Re: forestalling GNU incompatibility - proposal for binary relative dynamic linking
Date: Mon, 24 Jan 2005 18:08:52 -0500
User-Agent: KMail/1.7.2
Cc: gcc@gcc.gnu.org, binutils@sources.redhat.com, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
References: <20050124222449.GB16078@venus>
In-Reply-To: <20050124222449.GB16078@venus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501241808.52092.vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 January 2005 05:24 pm, Edward Peschko wrote:
> After spending *two weeks* on various ways of building glibc,
> I'm convinced that the gnu/linux toolchain is in great danger of
> losing interoperability.

sounds like what you want is already being tackled by OSDL and their Binary 
Regression Testing group ...
http://groups.osdl.org/apps/group_public/workgroup.php?wg_abbrev=binary_sig
http://www.osdl.org/docs/isv_issues_and_binary_testing.pdf
-mike
