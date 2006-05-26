Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWEZEPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWEZEPe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWEZEPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:15:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:20046 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030221AbWEZEPd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:15:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N/OTnkwQNLrWfZnLuTVAOu4KVRzEBhm8Y+Rnx3/+a0uLk0J2h6q4ZjQIY382T+VzXvwn+y2SXuqmdI7oXjFvh9WnCXlvWvC5BHfcV9geSzidk2LWIAVauDIx6rPm7W8AwidW7q6kHa8OYh2D9SbKO4csYMnQ3D1b0BgQmUeKtfk=
Message-ID: <4ae3c140605252115n7b040a99l6633ba387ce48358@mail.gmail.com>
Date: Fri, 26 May 2006 00:15:32 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: why svc_export_lookup() has no implementation?
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that functions like exp_get_by_name() calls function
svc_export_lookup(). But I cannot find the implementation of
svc_export_lookup(). I can only find the function definition. HOw can
this happen?

Can someone give me a hand?

Thanks!

-x
