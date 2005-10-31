Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVJaSKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVJaSKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 13:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVJaSKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 13:10:04 -0500
Received: from main.gmane.org ([80.91.229.2]:13722 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932527AbVJaSKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 13:10:01 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [git patches] 2.6.x libata updates
Date: Mon, 31 Oct 2005 19:06:25 +0100
Message-ID: <1x49vesl5uhbq$.ay8lwtk9fz30$.dlg@40tude.net>
References: <20051029182228.GA14495@havoc.gtf.org> <7vpspmhxhz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.62.0510310109250.16065@qynat.qvtvafvgr.pbz> <200510310334.35597.rob@landley.net> <xuqtrovd2yxc$.u541lhorc80y.dlg@40tude.net> <Pine.LNX.4.62.0510310945400.16906@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-138-251.37-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005 09:49:28 -0800 (PST), David Lang wrote:

> On Mon, 31 Oct 2005, Giuseppe Bilotta wrote:
> 
>> Trac has a 'Session ID' key that stores something like a cookie,
>> except that it's serverside. Something halfway a cookie and an actual
>> login. The user can write down the session ID or just assign its own,
>> and the re-enter the session ID and all things are restored to the
>> settings he had chosen. Something like this, maybe?
> 
> saving the state on the server means that you have to deal with (or 
> somehow eliminate) collisions between different users, it means that you 
> need to have the server-side data time out and get garbage collected, and 
> in general adds significant complexity to the project.

Well, I honestly don't have the slightest idea about this is handled
internally by Trac, but it seemed to be that something like this would
fit the needs, more or less. Of course it may need to be tuned for the
specific purpose ...

-- 
Giuseppe "Oblomov" Bilotta

"E la storia dell'umanità, babbo?"
"Ma niente: prima si fanno delle cazzate,
 poi si studia che cazzate si sono fatte"
(Altan)
("And what about the history of the human race, dad?"
 "Oh, nothing special: first they make some foolish things,
  then you study what foolish things have been made")

