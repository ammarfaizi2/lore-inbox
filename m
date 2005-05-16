Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVEPI1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVEPI1K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 04:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVEPI1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 04:27:10 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:47233 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261246AbVEPHY5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 03:24:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=muA24omNkZ/wWTJJGaOLFqe3MUa7hDSar0tnRirABp3OglP1PXNM7tnqeVejccofUKWiEGFHirSV6xS86D0D/n5CngUWjKyvskv14ZT8WkT6o+vbDVO8LXd4ZTujq9JyYu8mBhDFkcXXKol9L9srLakcRrRz8Zng0m1AuYg60To=
Message-ID: <b82a8917050516002466727179@mail.gmail.com>
Date: Mon, 16 May 2005 12:54:57 +0530
From: Niraj kumar <niraj17@gmail.com>
Reply-To: niraj17@iitbombay.org
To: lavin.p@redpinesignals.com
Subject: Re: Timestamp API ??
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42883FEF.5000404@redpinesignals.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42883FEF.5000404@redpinesignals.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/05, P Lavin <lavin.p@redpinesignals.com> wrote:
> Hi All,
> Can anyone tell me how to get the timestamp in my WLAN driver.
> Please letme know weather any kernel API's are available for this ??

Check this :
http://lwn.net/Articles/22808/

Niraj

> Thx & Rgds,
> Lavin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
-----------------------------------------------------------------
http://www.nirajkumar.net
