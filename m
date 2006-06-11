Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWFKGMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWFKGMi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 02:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWFKGMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 02:12:38 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:63378 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932570AbWFKGMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 02:12:37 -0400
Date: Sun, 11 Jun 2006 02:09:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: mixing 32 and 64 bit?
To: Dieter Stueken <stueken@conterra.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606110211_MC3-1-C21E-301D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44893D00.8090807@conterra.de>

On Fri, 09 Jun 2006 11:18:56 +0200, Dieter Stueken wrote:

> I just wonder how some userland applications are able to use 64-bit 
> capabilities although they are started by an  ELF 32-bit binary. I observed
> this when installing vmware: Even if the binary is an ELF32, it is
> able to provide an 64Bit ABI to its guest OS. Until now I thought a
> process is either 32bit or 64bit. Seems this is not true. 
> 
> Has some one a good link or entry point about this topic?
> I could not find a matching keyword to search for. 

http://marc.theaimsgroup.com/?t=110202845100001&r=1&w=2

-- 
Chuck

