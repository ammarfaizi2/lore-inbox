Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316895AbSGXGlv>; Wed, 24 Jul 2002 02:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316893AbSGXGlv>; Wed, 24 Jul 2002 02:41:51 -0400
Received: from signup.localnet.com ([207.251.201.46]:56042 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S316892AbSGXGlu>;
	Wed, 24 Jul 2002 02:41:50 -0400
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.27 enum
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
	<3D3BE421.3040800@evision.ag> <20020722160118.G6428@redhat.com>
	<20020722.191152.08962327.davem@redhat.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20020722.191152.08962327.davem@redhat.com>
Date: 24 Jul 2002 02:44:59 -0400
Message-ID: <m3d6tdmxp0.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bcrl> Please don't apply this.  By leaving the trailing "," on enums,
bcrl> additional values can be added by merely inserting an additional
bcrl> + line in a patch, otherwise there are excess conflicts when
bcrl> multiple patches add values to the enum.

davem> I totally agree.

Is my memory hosed or was there some years back a patch that
specifically *added* the trailing commas to the tree, for the express
reasons Ben mentions above?

-JimC

