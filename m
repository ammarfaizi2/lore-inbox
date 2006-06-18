Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWFRXZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWFRXZP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 19:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWFRXZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 19:25:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:10541 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750740AbWFRXZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 19:25:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T1gBqAgQlHVJpIgyalXV5iXbvclYKPMLgwJLWgIxyB9CokeJZTQfh63h56P6voFtvUiBTUdslLftitIBHfWS+bEwIWhEFGtVVjLJ5rIAgbrt4u4/56aX3DTEum5DTw0gmeY9RpWkWmBNGhjH/6sD+xUr6kchwnC3wYJ91DzCrgA=
Message-ID: <bda6d13a0606181625k4c1deba9rbc35d6a94bb623a1@mail.gmail.com>
Date: Sun, 18 Jun 2006 16:25:12 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Samuel Thibault" <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
In-Reply-To: <20060618225200.GB30726@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr>
	 <20060618223906.GA30726@animx.eu.org>
	 <20060618224051.GE4744@bouh.residence.ens-lyon.fr>
	 <20060618225200.GB30726@animx.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got one lying around where /bin->/usr/bin and /usr is a mountpoint.
init=/sbin/sh boots at need.
