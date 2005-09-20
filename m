Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVITJcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVITJcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 05:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVITJce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 05:32:34 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:7204 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964944AbVITJce convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 05:32:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gH1u2dBCbOLR632xHFVHUvTjzVldCW2qmUiFM355JRnff0KNd7HF/shXPfc6erFJLDWh81EhZRv92FVc6iI18VU+BpNh5XJ/BwbBNwVsdV0tJ9t5WWfUtg8EKouCdaOhSVef6k7b8WewWivZmtTgzD7qZPOj8h9gTJa51WQAN7w=
Message-ID: <3b8510d805092002326a1a3d71@mail.gmail.com>
Date: Tue, 20 Sep 2005 15:02:33 +0530
From: Thayumanavar Sachithanantham <thayumk@gmail.com>
Reply-To: thayumk@gmail.com
To: Ustyugov Roman <dr_unique@ymg.ru>
Subject: Re: [PATCH] kbuild: using well known kernel symbols as module names.
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200509201332.32333.dr_unique@ymg.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509191432.58736.dr_unique@ymg.ru>
	 <200509201213.44638.dr_unique@ymg.ru>
	 <3b8510d8050920015139d45449@mail.gmail.com>
	 <200509201332.32333.dr_unique@ymg.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For me it works with single quotes. Anyhow it's okay. Thanks.

Regards,
Thayumanavar S.
