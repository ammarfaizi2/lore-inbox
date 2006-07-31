Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWGaSlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWGaSlg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWGaSlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:41:36 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:30215 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030312AbWGaSlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:41:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Qa/HiOH9JTccOBPcZ043YI6dVvVJL8EAb5X72meOFA+4Ii22xevVAnnxfs5VudFae4bbPCEM8acRDM3NCQhGPwK6b0dWygo29flbG/qHyWkY7E/znXMww+oEewvf0fuxKbkdQzVGqYn3iVYc2c+Ln9Ei4BVFzGXuQdEqPxlZjtg=
From: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Date: Mon, 31 Jul 2006 11:41:28 -0700
User-Agent: KMail/1.8.1
Cc: w@1wt.eu, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <200607271521.38217.benjamin.cherian.kernel@gmail.com> <20060730003527.19bec8ce.zaitcev@redhat.com>
In-Reply-To: <20060730003527.19bec8ce.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607311141.29600.benjamin.cherian.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

>How about now?

Much better! For me, everything seems to be working. No segfaults, and 
everything seems to work.

Thanks,

Ben
