Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVKTVMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVKTVMR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVKTVMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:12:17 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:55801 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750800AbVKTVMQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:12:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bRsfWAzbfPYz/PlzBKml4MriTVLThlJKGRTyJMGF0U2yZdW2Dt0ZFGSNLqBwcEtebchs3G+KyVt4tZQKRoe9xn0HKPPW5pklluFNFcWk9T1QfzyzNrbnsBJhHS5Ctn2fd7N/U4U6RSoBJ9iWCt+qNb+X8GgBpVDPz5N0b9EvHBM=
Message-ID: <9611fa230511201312r5f43e8ady7023b4bde170596e@mail.gmail.com>
Date: Sun, 20 Nov 2005 21:12:15 +0000
From: Tarkan Erimer <tarkane@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Sun's ZFS and Linux
In-Reply-To: <20051119172337.GA24765@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9611fa230511181538g3e8ec403uafa9ed32b560fb0c@mail.gmail.com>
	 <20051119172337.GA24765@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/05, Theodore Ts'o <tytso@mit.edu> wrote:
> That wouldn't be a "port", it would have to be a complete
> reimplementation from scratch.  And, of course, of further concern
> would be whether or not there are any patents that Sun may have filed
> covering ZFS.  If the patents have only been licensed for CDDL
> licensed code, then that won't help a GPL'ed covered reimplementation.

Thanks for the explanation. BTW, I wonder something: Is there any
possibility to give GPL an exception to include and/or link to CDDL
code?

Thanks.
