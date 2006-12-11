Return-Path: <linux-kernel-owner+w=401wt.eu-S937108AbWLKQbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937108AbWLKQbv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937116AbWLKQbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:31:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:26955 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937108AbWLKQbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:31:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I6RPnAkv/oPPKo61kUp/uxVLVPYykIhT6wsyNGEPsSuU/Mx1wcbdiTvMXx/pVgzFvkiFueDRPq6g7cS4TCqcH1jO+Ib9GWCBs+YyNvyXfqoI3S4y7C9r+5RY6p41qyKCSRBfcvFiKl6P0fGAzD7CfYf3wtpyls9YzuqdQUgszrc=
Message-ID: <cc723f590612110831x1c49e876h179df627be005852@mail.gmail.com>
Date: Mon, 11 Dec 2006 22:01:48 +0530
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
To: "Mauricio Lin" <mauriciolin@gmail.com>
Subject: Re: kobject_uevent() question
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
In-Reply-To: <3f250c710612110653l7827c4dcg4bb47adbe7fe08e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061128161218.43358.qmail@web51813.mail.yahoo.com>
	 <90539.55300.qm@web51815.mail.yahoo.com>
	 <20061128195532.GA13705@kroah.com> <457C3E11.8050401@gmail.com>
	 <3f250c710612110653l7827c4dcg4bb47adbe7fe08e8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/06, Mauricio Lin <mauriciolin@gmail.com> wrote:
> Hi Aneesh,
>
> I have posted a patch for that as well. You can check it at
> http://lkml.org/lkml/2006/11/30/315.
>


Changes i posted was with respect to a latest kernel and also had some
more failure case properly returning error. So i picked my diff added
the commit message and function documentation from your diff. I have
posted a new diff with sign-off. Let me know what you think.

-aneesh
