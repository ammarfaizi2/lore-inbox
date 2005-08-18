Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVHRG3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVHRG3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVHRG3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:29:05 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:62341 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750800AbVHRG3E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:29:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B72Hh52jM5u86x6s9G2TxML/spVarLgSCVGUBmyrBdFT6zlWo3kqevcLel2mhoELkwfrU+uReX1+rRbSUKBjQbDTBJ6uDZP/yV6o6+eYEH3utkn9GLROnVU0yvbVEyZiPvmQbwtTrAtDp4ooBhhRVMufCtbtWuPMn+OOiuDYPY0=
Message-ID: <29495f1d05081723293c2bd337@mail.gmail.com>
Date: Wed, 17 Aug 2005 23:29:03 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: [PATCH 1/3] dlm: use configfs
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-cluster@redhat.com
In-Reply-To: <20050818060750.GA10133@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050818060750.GA10133@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/05, David Teigland <teigland@redhat.com> wrote:
> Use configfs to configure lockspace members and node addresses.  This was
> previously done with sysfs and ioctl.
> 
> Signed-off-by: David Teigland <teigland@redhat.com>

Are you the official maintainer of the DLM subsystem? Could you submit
a patch to add a MAINTAINERS entry? I was looking for a maintainer to
send the dlm portion of my schedule_timeout() fixes to, but there
wasn't one listed.

Thanks,
Nish
