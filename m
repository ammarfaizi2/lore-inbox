Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVF1Re2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVF1Re2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVF1ReW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:34:22 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:35796 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262157AbVF1Rc1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:32:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OxW6fp43rXjnqC0xJSwg0MfcvuwLcIdfhxdYFFn89aX3/NSfb4KEjV17s/gloBzEGNpW2YHeYCgpcUciELjFoijuFuBgvNDZ4e3xyksvtWIHHLq8vH9fmg0B5FSaZ5IERnVmupBQMYe01wBbE+J5pYR/pQrtiLGfENFtTDwfRWY=
Message-ID: <699a19ea05062810311934eb91@mail.gmail.com>
Date: Tue, 28 Jun 2005 23:01:54 +0530
From: k8 s <uint32@gmail.com>
Reply-To: k8 s <uint32@gmail.com>
To: Michael Becker <michbec@t-online.de>
Subject: Re: IPSec Inbound Processing Basic Doubt
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <699a19ea05062810087b79f12f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <699a19ea050623105516cd5eb8@mail.gmail.com>
	 <506243806.20050627182416@t-online.de>
	 <699a19ea05062810087b79f12f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also can you please tell me what is dst_input() forloop meant for .
Infact the code seems to match for dst_output() in terms of the 
NET_XMIT_BYPASS usage.
Infact I saw that ip_rcv_finish() calls this dst_input() what purpose
does it serve.



 S.Kartikeyan
 http://www.geocities.com/kartikeyans/
