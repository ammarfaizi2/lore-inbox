Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVBZRTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVBZRTV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 12:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVBZRTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 12:19:20 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:25783 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261236AbVBZRTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 12:19:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:organization:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=E/GfhlMoD3FwdkXXHCp9uc7iIpPe9B6YRetsGh6u5cKs0WKvxkzCE/sBS4vb1JGMG0c8/LUZp20Vx1+TGTVU04xNsJOPBi4m6/99vgIGmLso1Ke89r1HzEdVWvUpUB5zeBG84f2eC+jR13OocjaY9YBuFam6dXD8Y7JFf071PQg=
From: Vicente Feito <vicente.feito@gmail.com>
To: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
Subject: Re: how to use schedule_work()
Date: Sat, 26 Feb 2005 14:21:09 +0000
User-Agent: KMail/1.7.1
References: <Pine.LNX.4.60.0502262150190.18124@lantana.cs.iitm.ernet.in>
In-Reply-To: <Pine.LNX.4.60.0502262150190.18124@lantana.cs.iitm.ernet.in>
Organization: none
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502261421.09292.vicente.feito@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is for workqueues, it includes schedule_work() and how to call it
http://lwn.net/Articles/23634/

Vicente
