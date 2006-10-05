Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWJENrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWJENrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWJENrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:47:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:63867 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750924AbWJENrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:47:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=XI/zgaI1B+CXNIvn1liIdYsTtwhMhITHqlfP1jZ27fYSrFh3IfsqlP7XYbIuiBuPym4mVwrvtM/IgBbfdZ2lVN6LWH9ruHJPnG5tQIOFxL/1YVINSv2+PrBiJNFuP6q2YTmcHu8d/IlxRn83d0wtXgU8K/VI8baC5oq+lQaDODM=
Date: Thu, 5 Oct 2006 17:47:34 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dennis Heuer <dh@triple-media.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sunifdef instead of unifdef
Message-ID: <20061005134734.GA5335@martell.zuzino.mipt.ru>
References: <20061005150816.76ca18c2.dh@triple-media.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005150816.76ca18c2.dh@triple-media.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 03:08:16PM +0200, Dennis Heuer wrote:
> unifdef is not only very old and unmaintained, the binary does not work
> and the source does not compile on a pure x86_64 system. There is
> another tool that worked for me--though it 'closed with remarks'--and
> that was updated recently (several times this year). It is called
> sunifdef, is under an equal (new) BSD license, and is proposed to be
> the successor of unifdef. See the project page:
>
> http://www.sunifdef.strudl.org/

What about posting compiler errors instead of suggesting something that
is 10 times bigger?

