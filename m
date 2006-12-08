Return-Path: <linux-kernel-owner+w=401wt.eu-S1760713AbWLHNu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760713AbWLHNu0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 08:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760715AbWLHNu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 08:50:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:1453 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760713AbWLHNu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 08:50:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=m2zH41knNC+38z2Na8+RBgAaAcsnVUdOUiqZAHcsgpu9/zhsT4gN/xkvqkUsn6k26PAbBIcQPD3/3C9w73w5xnX7HUy7YbJX7R+XJIxS8Sj6gS59Lea1E+aUZplfbxrDlb4FgHydVTlh2PHDVO7/hE9qgbd69xI5Dh6OYQAq48A=
Message-ID: <84144f020612080550p6d368d05r1a36df44f4b986e7@mail.gmail.com>
Date: Fri, 8 Dec 2006 15:50:24 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: 2.6.19: slight performance optimization for lib/string.c's strstrip()
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <457975AE.31261.15F652B2@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <457975AE.31261.15F652B2@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-Google-Sender-Auth: 4f94b04ef4938b81
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/06, Ulrich Windl <ulrich.windl@rz.uni-regensburg.de> wrote:
> my apologies for disobeying all the rules for submitting patches, but I'll suggest
> a performance optimization for strstrip() in lib/string.c:

Makes sense. Please submit a patch.
