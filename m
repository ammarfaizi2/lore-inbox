Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUCQSSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUCQSSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:18:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:9363 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261907AbUCQSSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:18:35 -0500
Date: Wed, 17 Mar 2004 09:42:55 -0800
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
       Michael Hunold <hunold@convergence.de>
Subject: Re: [RFC][2.6] Additional i2c adapter flags for i2c client isolation
Message-ID: <20040317174255.GE19060@kroah.com>
References: <4056C805.8090004@convergence.de> <20040316154454.GA13854@kroah.com> <20040316201426.1d01f1d3.khali@linux-fr.org> <20040316195325.GA22473@kroah.com> <1079515049.405817a9a3da0@imp.gcu.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079515049.405817a9a3da0@imp.gcu.info>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 10:17:29AM +0100, Jean Delvare wrote:
> How would we export the value though? Numerical, with user-space headers
> to be included by user-space applications? Or converted to some
> explicit text strings so that no headers are needed?

A text string would be simple enough to use.

thanks,

greg k-h
