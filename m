Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVEMP12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVEMP12 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 11:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVEMP11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 11:27:27 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:27592 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262290AbVEMP1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 11:27:25 -0400
In-Reply-To: <4284C2B5.5040604@fujitsu-siemens.com>
Subject: Re: Again: UML on s390 (31Bit)
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Ulrich Weigand <uweigand@de.ibm.com>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OFA2B0C767.4C8614D3-ONC1257000.00541583-C1257000.0054CC70@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 13 May 2005 17:26:13 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 13/05/2005 17:27:23
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Meanwhile I've tried.
>
> Your patch absolutely doesn't change host's behavior in the situation,
> that is relevant to UML.

And as I understand that is because the SIGTRAP is not delivered
by the normal signal mechanism.

> I've prepared and attached a small program that easily can reproduce
> the problem. I hope this will help to find a viable solution.

That is cool, thanks. Will certainly speed up debugging on my side.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


