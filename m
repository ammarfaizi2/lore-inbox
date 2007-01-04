Return-Path: <linux-kernel-owner+w=401wt.eu-S965083AbXADVg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbXADVg2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbXADVg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:36:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:39123 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965085AbXADVg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:36:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uYkcqH3RZxbqUCETFDA9yuvYtqIOPqFXjkNBrwYl28xqzdB02utdrI+JZGWWoZ2ekSnBLMgzqhQyppo2sTQflo2SH3iEYlNeaAR5N6en5bfCnn6jV0WImkgwwht4Wt2ZPhDczjSxM3An1IYiHyiw4eO6tkQ/U4l3T7ilWwczopE=
Message-ID: <ec8d0a9d0701041336p301b31ccwfcbdce4498c34640@mail.gmail.com>
Date: Thu, 4 Jan 2007 22:36:26 +0100
From: "Tomasz Krynicki" <tomasz.krynicki@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ACL support patch for > 2.4.29
In-Reply-To: <ec8d0a9d0701040736j2d872a22ge65584a38bbfbd74@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ec8d0a9d0701040736j2d872a22ge65584a38bbfbd74@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried and 0.8.73 didn't applies correctly for 2.4.34. There are some
Hunk's FAILED...
I got problems to forward patch from 2.4.29 to .34.
