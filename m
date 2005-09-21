Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbVIUTq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbVIUTq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVIUTqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:46:25 -0400
Received: from mail.linicks.net ([217.204.244.146]:54287 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751410AbVIUTqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:46:25 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: A pettiness question.
Date: Wed, 21 Sep 2005 20:46:15 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509212046.15793.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This give a enum of {0,1}. If test is not 0, !!test will give 1,
>> otherwise 0.
>>
>> Am I right?
> 
> Yes.  I think of it as a "truth value" predicate (or operator).

Interesting.  I thought maybe this way was trick, until later I experimented.

My post here (as Bill Stokes):

http://www.quakesrc.org/forums/viewtopic.php?t=5626

So what is the reason to doing !!num as opposed to num ? 1:0 (which is more 
readable I think, especially to a lesser experienced C coder).  Quicker to 
type?

My quick test shows compiler renders both the same?

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
