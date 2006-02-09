Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWBIOgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWBIOgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 09:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWBIOgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 09:36:32 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:65102 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932285AbWBIOgb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 09:36:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lWt+PA2wHAhTBdsVGL6U7jmLdWy8/fwr/rypCBdaNMxIScvypNpMMz+o4f8zn/SCsrsDHDKYrLF20YhkBp9dw4sfHWrFitPEgJhFal3JCMJkoTNjb77DlKjw1v1+pxEGu4SANqM5FFdNtA3EbnEFlr0hm8gVpypTLsuawwlqC0E=
Message-ID: <625fc13d0602090636i941d69fx2ca2fd96b04ff7b2@mail.gmail.com>
Date: Thu, 9 Feb 2006 08:36:30 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: git for dummies, anyone?
Cc: Jes Sorensen <jes@sgi.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43EB4F05.8090400@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060208070301.1162e8c3.pj@sgi.com>
	 <yq0vevollx4.fsf@jaguar.mkp.net> <43EB4F05.8090400@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Check out:
> http://linux.yyz.us/git-howto.html

Any reason that doesn't use the git:// protocol?  It'll fetch the tags
for you, etc.  And I think it's the "preferred" way of using git when
working with the kernel.

josh
