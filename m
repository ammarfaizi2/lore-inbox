Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbVKIWQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbVKIWQx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbVKIWQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:16:53 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:54904 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030445AbVKIWQw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:16:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QLfh5kgF746CQMIdXna6KWYNF3uPAYPlDd9g5vuC+QAVUodjhurBh/H34hwSpZPPgWqrlwAapEB2I+bJHLtEa2ZNINGe7GEUgpQ0kpLegBWknN/HkQWRHwv0SYcRElpETeGWZR2addUcwc7k+NSz5iSDR1zvlPBBCF/QNkqxE0w=
Message-ID: <58cb370e0511091416q1f412ee1ia63a8282a9936467@mail.gmail.com>
Date: Wed, 9 Nov 2005 23:16:51 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: wrlk@riede.org
Subject: Re: [PATCH] ide-scsi fails to call idescsi_check_condition for things like "Medium not present"
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1130717029l.3354l.18l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1130717029l.3354l.18l@serve.riede.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied, thanks
