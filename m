Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbUDTOjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUDTOjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 10:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUDTOjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 10:39:52 -0400
Received: from mail.cyclades.com ([64.186.161.6]:7657 "EHLO mail.cyclades.com")
	by vger.kernel.org with ESMTP id S262866AbUDTOjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 10:39:49 -0400
Date: Tue, 20 Apr 2004 11:40:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Roman Medina <roman@rs-labs.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.26 doesn't compile? ("error: `__cmpxchg' previously defined here")
Message-ID: <20040420144058.GB13374@logos.cnet>
References: <31145.194.224.100.28.1082362588.squirrel@194.224.100.28> <20040419102710.06bcdf9a.rddunlap@osdl.org> <lq8880hq37q1b4ffpmn7idvj8gcqps5iqo@4ax.com> <20040419125647.2b19e83e.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419125647.2b19e83e.rddunlap@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch applied, 

Thanks Randy!

On Mon, Apr 19, 2004 at 12:56:47PM -0700, Randy.Dunlap wrote:

> That would be this changeset:
> http://linux.bkbits.net:8080/linux-2.4/diffs/include/asm-i386/system.h@1.16?nav=index.html|src/|src/include|src/include/asm-i386|hist/include/asm-i386/system.h
> 
> 
> This patch (below) works for me with your original i386 .config file.
