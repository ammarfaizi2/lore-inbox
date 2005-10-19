Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVJSLzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVJSLzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVJSLzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:55:00 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:28480 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750820AbVJSLy5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:54:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=s8J0L4PHwUoUXJHwrO385ZINxW0oYL+dVLb8go+jIz6KmZeP6P6xZHLcWAdTlnbYVzsmaJ13To3e5C1EuvtvSztUVKZjOea3nV84QhrueOLNA2kJmoG4QQHR6LlZ0mM2QyisQtjllVQ4vYXZoAaCHCFLe37h3EJsVd0is388Bcc=
Date: Wed, 19 Oct 2005 13:54:05 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Subbu <subbu@sasken.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       subbu2k_av@yahoo.com
Subject: Re: spec file
Message-Id: <20051019135405.afd251b6.diegocg@gmail.com>
In-Reply-To: <Pine.GSO.4.30.0510191330120.20601-100000@sunm21.sasken.com>
References: <Pine.GSO.4.30.0507181124560.28721-100000@sunrnd2.sasken.com>
	<Pine.GSO.4.30.0510191330120.20601-100000@sunm21.sasken.com>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 19 Oct 2005 13:33:56 +0530 (IST),
Subbu <subbu@sasken.com> escribió:


> 
> 
> Hi ,
> 
> Please help me to build an rpm


There're a "make rpm" and "make binrpm-pkg". There's a spec
file in scripts/package/mkspec - it should be easy to adapt it to your
needs.
