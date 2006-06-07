Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWFGGvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWFGGvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 02:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWFGGvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 02:51:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:30250 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751085AbWFGGvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 02:51:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m/mQqScGZZReytAL26TenPZDynV22FVbKdsTbREFSBAlbPFJCF0EKv5Dd/CLsmA9SQEU9y8C2SvCBCOJeL9XLMShWfgXeftEdKXQJbjkoYDArCsLYlqSxok4VB/Tk6Zg5o/ZpGbH+FAQ40HH0muxMqgOKlv6eraGqE2ppImDjdM=
Message-ID: <bda6d13a0606062351i5c94414fpa03ee2ce3dd180ae@mail.gmail.com>
Date: Tue, 6 Jun 2006 23:51:07 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: klibc (was: 2.6.18 -mm merge plans)
In-Reply-To: <200606071425.35802.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <200606071400.49980.ncunningham@linuxmail.org>
	 <e65jj9$m9p$1@terminus.zytor.com>
	 <200606071425.35802.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did anybody ever fix the can't pivot_root() the rootfs filesystem;
hense can't use on a loopback system backed by NTFS?
