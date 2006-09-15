Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWIOIjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWIOIjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWIOIjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:39:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:43400 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750755AbWIOIjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:39:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=OircXKA2tqHry2bTy/DxFkSwjVAshXH2qK0QDDewdf5I0MO3VPQMRpWsFGHzj3FFVnJCdNGpKFkHyVkBsJEZ2HOTGvLXqJhWEvL4i5XlnvVkQ04XJ2s2So3+SixVlron162wmAw7DmYxk8lYGZFPlcwPBWIJz0aDoIkl1wIxEMg=
Date: Fri, 15 Sep 2006 10:38:25 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Razvan Gavril <razvan.g@plutohome.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Some ooupses with 2.6.18rc7
Message-ID: <20060915103825.GA2876@slug>
References: <450A64CC.5060008@plutohome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450A64CC.5060008@plutohome.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 11:31:08AM +0300, Razvan Gavril wrote:
> EIP:    0060:[<00000001>]    Tainted: P      VLI
Your kernel seems to have loaded some proprietary module. Is it possible
the reproduce the issue without that module?

Regards,
Frederik
