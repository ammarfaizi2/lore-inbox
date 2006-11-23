Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933627AbWKWMdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933627AbWKWMdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 07:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933630AbWKWMdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 07:33:38 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:18501 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S933627AbWKWMdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 07:33:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=DyoLxAMsTGD8FrCvizLbeB95NvY/91RRLyADnN++CdByV1sCS3uqC0i45UnbusSzxQt4zkX79qxxxoG1tprGw8BNHBDU+7/qPe13aCICs3vYtNIbk1zAqbDRylGMnim7/dFdN0DnEwVbHdHtoRnlCRBhEgBj6g3YyXb0R9Er21o=
Message-ID: <f36b08ee0611230433r372c9320wcec43b8cc2679213@mail.gmail.com>
Date: Thu, 23 Nov 2006 14:33:37 +0200
From: "Yakov Lerner" <iler.ml@gmail.com>
To: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: coping with swap-exhaustion in 2.4.33-4
In-Reply-To: <f36b08ee0611230430k9b2b625qc8d1b93031e09d14@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3817_27212433.1164285217401"
References: <f36b08ee0611230430k9b2b625qc8d1b93031e09d14@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3817_27212433.1164285217401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/23/06, Yakov Lerner <iler.ml@gmail.com> wrote:
>    I made a small test (below) and I run it as root and as non-root, having

Here is memstress.c, tiny memory hog that I referred to in previous email.

Yakov

------=_Part_3817_27212433.1164285217401
Content-Type: application/octet-stream; name=memstress.c
Content-Transfer-Encoding: base64
X-Attachment-Id: f_euv59d06
Content-Disposition: attachment; filename="memstress.c"


------=_Part_3817_27212433.1164285217401--
