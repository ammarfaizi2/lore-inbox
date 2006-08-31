Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWHaNOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWHaNOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWHaNOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:14:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:41533 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932201AbWHaNOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:14:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eRYC0+P7cI70NyXd3emlQD+mwdjnHTfou+WtCLh55f8YE0WzsY+Ce4jlmM0+yrvcPAQDpUSoyB9cQsD4Qldv0wWAsNoAtzPHHVJLzS8ppeO7F61ZreNl/wR0NucPULRpOHDykM1GwP0ythqDQG+sAUgmWIqxptptOBREszkr2OE=
Message-ID: <9a8748490608310614w2feac245r94c5c34b91e757e9@mail.gmail.com>
Date: Thu, 31 Aug 2006 15:14:46 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Pete Clements" <clem@clem.clem-digital.net>
Subject: Re: 2.6.18-rc5-git3 SMP fails compile
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200608311305.k7VD5iFW018562@clem.clem-digital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608311305.k7VD5iFW018562@clem.clem-digital.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/06, Pete Clements <clem@clem.clem-digital.net> wrote:
> fyi:
> 2.6.18-rc5-git3 fails compile with SMP.
>

Known problem : http://lkml.org/lkml/2006/8/31/50

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
