Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423596AbWJZQ05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423596AbWJZQ05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423603AbWJZQ05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:26:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:26487 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423596AbWJZQ05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:26:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kUrS/6voPO4ESNM2KJopU1hq6caxaZismTQTOfkZzlIyBX57u289OqcBMYZkZPoHq4qrJYgdnZDg59HdD4TP36xSof1IfG12YYq8rr2a08Ukbm/OwrCu5RU7pdGeYvlbRAggidYG0MpbklW0xykhJ+zOhd8l+ldgOhC5XzM/Xfk=
Message-ID: <84144f020610260926x3765398coce0146c82a69f674@mail.gmail.com>
Date: Thu, 26 Oct 2006 19:26:54 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: Re: 2.6.18: unable to handle kernel paging request at virtual address e5e9ec24
Cc: admin@prnet.org, linux-kernel@vger.kernel.org
In-Reply-To: <4540C678.2060106@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <58488.212.24.212.169.1161860570.squirrel@server.prnet.org>
	 <4540C678.2060106@mbligh.org>
X-Google-Sender-Auth: 36e8b1e121c299b4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/26/06, Martin J. Bligh <mbligh@mbligh.org> wrote:
> Binary modules loaded. Don't do that.

To elaborate bit on what Martin said here, there aren't many
developers on LKML that are willing to debug a tainted kernel. Please
reproduce without any binary-only modules and post the results to get
help. Thanks.

                             Pekka
