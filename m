Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTJHBJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 21:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbTJHBJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 21:09:37 -0400
Received: from smtp12.eresmas.com ([62.81.235.112]:19947 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S262918AbTJHBJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 21:09:36 -0400
Message-ID: <3F8363B0.60301@wanadoo.es>
Date: Wed, 08 Oct 2003 03:09:04 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: syn uw <syn_uw@hotmail.com>, linux-kernel@vger.kernel.org, atulm@lsil.com,
       linux-megaraid-devel@dell.com
Subject: Re: Megaraid does not work with 2.4.22
References: <Pine.LNX.4.44.0310072151220.27859-100000@logos.cnet>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>>Here go some trivial fixes(add menu entry, list all compatibles
>>boards in help and put tab instead spaces) for megaraid2.
> 
> 
> Those are already in the merged megaraid2

This is a patch against 2.4.22-bk30, and it's
necessary to be able to compile megaraid2 and to
get help text from menuconfig.

-thanks-

