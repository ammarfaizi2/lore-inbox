Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWJWQFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWJWQFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbWJWQFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:05:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:46985 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751549AbWJWQFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:05:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=nkV9Cwxjh1icAd78AIpWs9AH0RtbIfzJBekpVVoFdboeif9f7f3Xodiz6d+rqDjQBkSk/Ko4JgU1KLfMkTORF101Mwm5UkM6TMQumULt6n5FszmylkH4iXZzTCGEqUy2ktB7OcQuxMuyhZF4G5ar+Tx88QTdXcbdet38sXSlODM=
Message-ID: <453CE85B.2080702@innova-card.com>
Date: Mon, 23 Oct 2006 18:05:47 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Miguel Ojeda <maxextreme@gmail.com>
CC: Franck <vagabon.xyz@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
References: <20061013023218.31362830.maxextreme@gmail.com>	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com> <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
In-Reply-To: <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda wrote:
> The driver is waiting in the -mm tree (-mm2 right now) for being
> included in the mainline kernel sometime in the future. If it is
> included, I will maintain it as I coded it as it apears in the
> MAINTAINERS file. Why are you so worried about it if I can ask? Do you
> want some more features or something like that?

Are you sure the patch you sent to Andrew is your latest patch
version ? For example I can't found any locks in the patch that
you normally added during the V6 patch version; auxlcddisplay.c
doesn't no exist...

		Franck
